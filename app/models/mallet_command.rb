class MalletCommand < ActiveRecord::Base
  belongs_to :mallet_run

  def run
    
    pid, p_stdin, p_stdout, p_stderr = Open4::popen4 command

    p_stdin.close
    self.stdout = ""
    self.stderr = ""
    self.state = "RUNNING"
    save!

    sleep 0
    while true
      ignored, status = Process::waitpid2( pid, Process::WNOHANG)
      self.stdout += read_nonblock(p_stdout)
      self.stderr += read_nonblock(p_stderr)
      if status 
        self.exit_status = status.exitstatus
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

  def read_nonblock( io) 
    buf = ""
    while true
      buf += io.read_nonblock( 4096)
    end
  rescue IO::WaitReadable
    puts buf
    return buf
  rescue EOFError
    puts buf
    return buf
  end
end
