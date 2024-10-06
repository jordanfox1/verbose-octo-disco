require 'todo/version.rb'
require 'json'
require 'securerandom'

class TaskCreator
  def initialize()
  end

  def create_id()
    return SecureRandom.uuid
  end

  def create(name = nil, description = nil, status = nil)

    if name == nil
      puts "please provide a name"
      return nil
    end

    status = case status
    when nil
      "todo"
    when "todo", "in progress", "done"
      status
    else
      "todo"
    end
      

    existing_tasks = JSON.parse(File.read('todo.json'))
    new_task = {name: name, description: description, status: status, id: create_id()}
    updated_tasks = existing_tasks << new_task

    File.write('todo.json', updated_tasks.to_json)
    return new_task
  end

  def get(id)
    tasks = JSON.parse(File.read('todo.json'))
    tasks.each do |task|
      if task['id'] == id
        return task
      end
    end
    return nil
  end

  def delete_by_id(id)
    tasks = JSON.parse(File.read('todo.json'))
    tasks.each do |task|
      if task['id'] == id
        tasks.delete(task)
        File.write('todo.json', tasks.to_json)
        return task
      end
    end
    return nil
  end

  def delete_by_name(name)
    tasks = JSON.parse(File.read('todo.json'))
    tasks.each do |task|
      if task['name'] == name
        tasks.delete(task)
        File.write('todo.json', tasks.to_json)
        return task
      end
    end
    return nil
  end

  def complete(id)
    tasks = JSON.parse(File.read('todo.json'))
    tasks.each do |task|
      if task['id'] == id
        task['status'] = 'done'
        File.write('todo.json', tasks.to_json)
        return
      end
    end
  end

  def update_name(id, name)
    tasks = JSON.parse(File.read('todo.json'))
    tasks.each do |task|
      if task['id'] == id
        task['name'] = name
        File.write('todo.json', tasks.to_json)
        return task
      end
    end
    return nil
  end

  def update_description(id, description)
    tasks = JSON.parse(File.read('todo.json'))
    tasks.each do |task|
      if task['id'] == id
        task['description'] = description
        File.write('todo.json', tasks.to_json)
        return task
      end
    end
    return nil
  end

  def list_all()
    tasks = JSON.parse(File.read('todo.json'))
    return tasks
  end

  def list_done()
    tasks = JSON.parse(File.read('todo.json'))
    tasks.each do |task|
      if task['status'] == 'done'
        puts task
      end
    end
  end

  def list_not_done()
    tasks = JSON.parse(File.read('todo.json'))
    tasks.each do |task|
      if task['status'] != 'done'
        puts task
      end
    end
  end
end
