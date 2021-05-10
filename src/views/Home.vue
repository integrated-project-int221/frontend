<template>

  <div class="home">
    <div class="container">
      <section
        class="bg-image-slide w-full mx-auto bg-nordic-gray-light flex pt-12 md:pt-0 md:items-center bg-cover bg-right"
        style="max-width: 1600px; height: 32rem"
      >
        <div class="container mx-auto">
          <div
            class="flex flex-col w-full justify-center items-start px-6 tracking-wide cursor-default"
          >
            <h1
              class="text-7xl my-4 text-black font-serif font-bold p-4 bg-yellow-500"
            >
              Guitar Store
            </h1>
            
          </div>
        </div>
      </section>

      <!--product-->
      <div class="my-8 mx-8">
        <div class="grid gap-3 md:grid-cols-1 lg:grid-cols-2">
          <product
            v-for="product in productResults"
            :key="product.productCode"
            :product="product"
            @deleteReview="deleteArray"
          ></product>
        </div>
      </div>

      <!--end home-->
      
    </div>
  </div>
</template>

<script>
import product from "../components/Product.vue";

export default {
  name: "Home",
  components: {
    product,
  },
  data() {
    return {
      productResults: [],
      openModal: false,
      // url: `${process.env.VUE_APP_ROOT_API}`
    };
  },

  methods: {
    deleteArray(id, image) {
      console.log(id, image);
      this.productResults = this.productResults.filter((product) => {
        return product.prodCode !== id
      })
    },

    goProductList() {
      this.$router.push("/productlist");
    },
    async reload() {
      this.productResults = await this.fetchProductResult();
    },
    async fetchProductResult() {
      try {
        const res = await fetch("http://207.46.228.91/backend/products/items");
        const data = await res.json();
        return data;
      } catch (error) {
        console.log(error);
      }
    },
  },
  async created() {
    this.productResults = await this.fetchProductResult();
  },
  
};
</script>

<style scoped>
.bg-image-slide {
  background-image: url("../assets/HomeGuitar2.jpg");
}
</style>