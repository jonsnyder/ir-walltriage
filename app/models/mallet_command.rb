class MalletCommand < ActiveRecord::Base
  belongs_to :mallet_run

  scope :job, lambda { |job| where(:job => job) }
  scope :jobs_like, lambda { |job| where( 'job LIKE ?', "%#{job}%") }
  
  def run( writer = nil)
    
    pid, p_stdin, p_stdout, p_stderr = Open4::popen4 command

    if writer
      Thread.new do
        writer.call p_stdin
      end
    else
      p_stdin.close
    end

    self.stdout = ""
    self.stderr = ""
    self.state = "RUNNING"
    save!

    sleep 0
    while true
      if mallet_run.state == "Canceled"
        Process::kill("INT", pid)
        self.state = "CANCELED"
        save!
        raise 'Job Canceled'
      end
      
      ignored, status = Process::waitpid2( pid, Process::WNOHANG)

      if block_given?
        stdout_tail ||= ""
        stdout_tail = read_lines_nonblock( stdout_tail, p_stdout) { |line| yield line }
      else
        self.stdout += read_nonblock(p_stdout)
      end
      self.stderr += read_nonblock(p_stderr)

      
      
      if status 
        self.exit_status = status.exitstatus
        if block_given? && stdout_tail != ""
          yield stdout_tail
        end
        self.state = "FINISHED"
        save!
        if status != 0
          raise "Non-zero Return Code"
        end
        break
      end

      
      save!
      sleep 1
    end

    
  end

  def read_lines_nonblock( last_line, io)
    last_line += read_nonblock( io)
    lines = last_line.split("\n")

    last_line = (last_line[-1] == "\n" ? "" : lines.pop)

    lines.each do |line|
      yield line
    end
    last_line
  end
    
    
    
  def read_nonblock( io) 
    buf = ""
    while true
      buf += io.read_nonblock( 4096)
    end
  rescue IO::WaitReadable
    return buf
  rescue EOFError
    return buf
  end
end
