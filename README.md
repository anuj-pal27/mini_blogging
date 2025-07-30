# Mini Blogging Platform

A modern, full-featured blogging platform built with Ruby on Rails, Devise, Bootstrap 5, and Sidekiq.

---

## 🚀 Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone https://github.com/anuj-pal27/mini_blogging.git
   cd mini_blogging
   ```

2. **Install dependencies:**
   ```sh
   bundle install
   yarn install # if using webpacker (optional)
   ```

3. **Setup the database:**
   ```sh
   rails db:create db:migrate db:seed
   ```

4. **Start Redis (for Sidekiq):**
   ```sh
   redis-server
   ```

5. **Start Sidekiq (in a new terminal):**
   ```sh
   bundle exec sidekiq
   ```

6. **Start the Rails server:**
   ```sh
   rails server
   ```

7. **Visit the app:**
   - [http://localhost:3000](http://localhost:3000) for the main site
   - [http://localhost:3000/admin/login](http://localhost:3000/admin/login) for the admin panel

---

## 🎨 Design Decisions

- **Bootstrap 5** for a modern, responsive, and consistent UI
- **Devise** for secure user authentication
- **Sidekiq** for background jobs (notifications on post publish)
- **Slug-based URLs** for SEO-friendly post links
- **Separation of concerns:**
  - User area (blog, comments, dashboard)
  - Admin area (hard-coded login, full content/user moderation)
- **Simple, clean, and accessible design**

---

## ✅ Implemented Features

- User authentication (Devise): sign up, login, edit profile, change password
- Posts system: create, edit, delete, draft/published status, slug URLs
- Comments system: users can comment, non-auth users can view
- Search & filtering: by title/content, status, own posts, date range
- User dashboard: manage own posts, see comment counts, post previews
- API endpoints: `/api/posts` and `/api/posts/:slug` (token auth, published only)
- Background jobs: notification/email simulation on publish (Sidekiq)
- Admin panel (hard-coded login): manage all posts, users, comments
- Responsive, Bootstrap-styled UI throughout

---

## 👤 Test User Credentials

- **Regular User:**
  - Email: `test@example.com`
  - Password: `password123`

- **Admin Panel:**
  - Username: `admin`
  - Password: `admin123`

---

## 📚 Notes
- To use the API, pass `Authorization: Bearer secret123` header or `?token=secret123` param.
- Make sure Redis and Sidekiq are running for notifications.
- You can customize the admin credentials in `Admin::SessionsController`.

---

Happy blogging! 🎉
