class Instructions
  
  # return all instructions as instances in an array, NoOp must be last
  def self.all
    instructions = []
    Dir["./instructions/*.rb"].each do |file|
      
      require file

      extension = File.extname(file)
      file_name = File.basename(file, extension)
      
      instruction = classify(file_name)
      instructions.push(instruction.new) unless instruction.eql?(NoOp)
    end

    instructions.push(NoOp.new)
    instructions
  end

  private

    def self.classify(snake_case)
      camel_case = snake_case.split('_').collect(&:capitalize).join
      Object.const_get(camel_case)
    end

end
