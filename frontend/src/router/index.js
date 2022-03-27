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
    name: "Profile",
    path: "/profile",
    component: () => import('@/views/Profile')
  },
  {
    name: "Friends",
    path: "/friends",
    component: () => import('@/views/Friends')
  },
  {
    name: "Groups",
    path: "/groups",
    component: () => import('@/views/Groups')
  },
  {
    name: "Messages",
    path: "/messages",
    component: () => import('@/views/Messages')
  },
  {
    name: "Photos",
    path: "/photos",
    component: () => import('@/views/Photos')
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
        component: () => import('@/views/admin/AdminUsers'),
      },
      {
        name: "AdminUserData",
        path: "userdata",
        component: () => import('@/views/admin/AdminUserData'),
      },
      {
        name: "AdminPublicPosts",
        path: "public-posts",
        component: () => import('@/views/admin/AdminPublicPosts')
      },
      {
        name: "AdminGroupPosts",
        path: "group-posts",
        component: () => import('@/views/admin/AdminGroupPosts')
      },
      {
        name: "AdminMessages",
        path: "messages",
        component: () => import('@/views/admin/AdminMessages')
      },
      {
        name: "AdminGroups",
        path: "groups",
        component: () => import('@/views/admin/AdminGroups')
      },
      {
        name: "AdminPublicComments",
        path: "public-comments",
        component: () => import('@/views/admin/AdminPublicComments')
      },
      {
        name: "AdminGroupComments",
        path: "group-comments",
        component: () => import('@/views/admin/AdminGroupComments')
      },
      {
        name: "AdminAlbums",
        path: "albums",
        component: () => import('@/views/admin/AdminAlbums')
      },

    ]
  },
  {
    name: "Search",
    path: "/search",
    component: () => import('@/views/Search')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
