class FrameBufferCommand < Command

  def match
    /^(fr|fb)$/ =~ @command
  end

  def execute(debugger)
    puts debugger.emular.frame_buffer.to_s
  end

end
