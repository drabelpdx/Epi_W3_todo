class Task
  attr_reader(:description)

  define_method(:initialize) do |description|
    @description = description
  end

  define_method(:description) do
    @description
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch('description')
      list_id = task.fetch("list_id").to_i()
      task.push(Task.new({:description => description, :list_id => list_id}))
    end
    tasks
  end

  define_method(:==) do |another_task|
    self.description().==(another_task.description())
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description) VALUES ('#{@description}');")
  end

end
