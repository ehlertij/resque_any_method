Adds methods to background any method in Resque. This is useful
for removing the large amounts of Resque code normally required
if backgrounding multiple methods in a single model.

## Methods

* `Class.resque(method, *args)` backgrounds a class method call.
* `resque(method, *args)` backgrounds an instance method call.
* `resque_queue(queue)` chooses which queue to add the backgrounded methods to.

## Examples
    class Post < ActiveRecord::Base
      include ResqueAnyMethod
      resque_queue :archive

      self << class
        def archive_old_posts(num_to_keep)
          # logic
        end
      end

      def archive
        # logic
      end
    end

    > Post.resque(:archive_old_posts, 5)
    # Backgrounds `Post.archive_old_posts(5)` for Resque.

    > post.resque(:archive)
    # Backgrounds `Post.find(post_id).archive` for Resque.
