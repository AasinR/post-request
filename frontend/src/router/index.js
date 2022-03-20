import Vue from 'vue'
import VueRouter from 'vue-router'


Vue.use(VueRouter)

const routes = [
  {
    name: "Index",
    path: "/",
    beforeEnter: (to, from) => {
      router.replace({name: "Login"})
    }
  },
  {
    name: "Login",
    path: "/login",
    component: () => import('@/views/Login')
  },
  {
    name: "Register",
    path: "/register",
    component: () => import('@/views/Register')
  },
  {
    name: "Admin",
    path: "/admin",
    component: () => import('@/views/Admin'),
    children: [
      {
        path: '/',
        beforeEnter: (from, to, next) =>{
          router.push('/admin/users')
        }
      },
      {
        name: "AdminUsers",
        path: "users",
        component: () => import('@/views/admin/Users'),
      },
      {
        name: "AdminPosts",
        path: "posts",
        component: () => import('@/views/admin/Posts')
      },
      {
        name: "AdminMessages",
        path: "messages",
        component: () => import('@/views/admin/Messages')
      },
      {
        name: "AdminGroups",
        path: "groups",
        component: () => import('@/views/admin/Groups')
      },
      {
        name: "AdminComments",
        path: "comments",
        component: () => import('@/views/admin/Comments')
      },
      {
        name: "AdminAlbums",
        path: "albums",
        component: () => import('@/views/admin/Albums')
      },

    ]
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
