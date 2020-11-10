# frozen_string_literal: true

module API
  module V1
    class Tasks < Grape::API
      helpers do
        def tasks
          @tasks ||= Task.order(created_at: :desc)
        end

        def task
          @task ||= Task.new(declared_params[:task])
        end

        def matched_task
          @matched_task ||= Task.find(params[:id])
        end

        params :task_params do
          requires :task, type: Hash do
            requires :title, type: String
            optional :description, type: String
            optional :active, type: Boolean
          end
        end
      end

      resource :tasks do
        desc 'Return all tasks'
        get do
          status(200)
          render(tasks, each_serializer: TasksSerializer)
        end
        
        desc 'Return task'
        params do
          requires :id, type: String, desc: 'ID of the task'
        end
        get ':id' do
          status(201)
          render(matched_task, serializer: TasksSerializer)
        end
        
        desc 'Create a new task'
        params do
          use(:task_params)
        end
        post do
          if task.save
            status(201)
            render(task, serializer: TasksSerializer)
          else
            status(422)
            error!(task.errors.full_messages, 422)
          end
        end

        desc 'Update task'
        params do
          use(:task_params)
        end
        patch ':id' do
          if matched_task.update(declared_params[:task])
            status(200)
            render(matched_task, serializer: TasksSerializer)
          else
            status(422)
            error!(matched_task.errors.full_messages, 422)
          end
        end
        
        desc 'Delete task'
        delete ':id' do
          if matched_task.destroy
            status(204)
          else
            status(422)
            error!(matched_task.errors.full_messages, 422)
          end
        end
      end
    end
  end
end
