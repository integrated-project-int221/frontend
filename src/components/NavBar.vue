<template>
  <nav id="nav" class="w-full top-0 p-1 text-white bg-black">
    <div class="flex justify-between">
      <div class="ml-6 self-center">
        <span>
          <router-link to="/">
            Home
          </router-link>
        </span>
      </div>
      <div class="mr-6 self-center">
        <router-link to="/teammember">Team </router-link>
        <router-link to="/addproduct" class="text-white font-medium">
          Add Product
        </router-link>
      </div>
    </div>
  </nav>
  <router-view />
</template>
<<<<<<< HEAD

=======
 
 
>>>>>>> 83f4f38685f067da629b460db81b4358f3b7e8fe
<script>
export default {};
</script>

<style scoped>
#nav {
  padding: 1em;
  position: sticky;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: white;
}

#nav a {
  @apply no-underline text-white  border-b-2 border-transparent hover:bg-gray-700 focus:bg-gray-700 uppercase tracking-wide font-bold text-lg p-2 mr-8;
}
#nav a.router-link-exact-active {
  @apply text-yellow-500 ;
}
</style>
