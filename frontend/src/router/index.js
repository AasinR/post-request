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
    path: "/profile/:userID",
    props: true,
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
    beforeEnter: (from, to, next) =>{
      Vue.nextTick(async () => {
        if(await router.app.isAdmin()){
          next();
        } else {
          next({name: 'NotFound'});
        }
      })
    },
    children: [
      {
        path: '/',
        redirect: '/admin/users',
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
        name: "AdminPictures",
        path: "pictures",
        component: () => import('@/views/admin/AdminPictures')
      },
      {
        name: "AdminAlbums",
        path: "albums",
        component: () => import('@/views/admin/AdminAlbums')
      },
      {
        name: "AdminFriends",
        path: "friends",
        component: () => import('@/views/admin/AdminFriends')
      },
      {
        name: "AdminFriendRequests",
        path: "friend-requests",
        component: () => import('@/views/admin/AdminFriendRequests')
      },
      {
        name: "AdminGroupMembers",
        path: "group-members",
        component: () => import('@/views/admin/AdminGroupMembers')
      },

    ]
  },
  {
    name: "Search",
    path: "/search",
    component: () => import('@/views/Search')
  },
  {
    name: "EditProfile",
    path: "/edit-profile",
    component: () => import('@/views/edit/EditProfile')
  },
  {
    name: "NotFound",
    path: "/not-found",
    component: () => import('@/views/NotFound')
  },
  {
    name: "GroupPage",
    path: "/group-page/:groupID",
    props: true,
    component: () => import('@/views/GroupPage')
  },
  {
    name: "AddGroup",
    path: "/add-group",
    component: () => import('@/views/add/AddGroup')
  },
  {
    name: "AlbumPage",
    path: "/album-page/:albumID",
    props: true,
    component: () => import('@/views/AlbumPage')
  },
  {
    name: "AddPhotosToAlbum",
    path: "/add-photos/:albumID",
    props: true,
    component: () => import('@/views/add/AddPhotosToAlbum')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})


router.beforeEach((to, from,next) => {
    Vue.nextTick(() => {
      if (to.name !== 'Login' && to.name !== 'Register' && !router.app.isLoggedIn()) {
        next({ name: 'Login' });
      } else {
        next();
      }
    })
})

router.beforeEach((to, from,next) => {
  Vue.nextTick(() => {
    if ((to.name === 'Login' || to.name === 'Register') && router.app.isLoggedIn()) {
      next({ name: 'Profile', params: {userID: Vue.$cookies.get("UserID")} });
    } else {
      next();
    }
  })
})


export default router
