<template>
  <div class="py-6">
    <div class="flex bg-white shadow-lg rounded-lg overflow-hidden border">
      <!--product data-->
      <img
        class=" w-2/5 object-cover object-center h-80"
        :src="'http://172.22.0.3:8080/images/get/' + this.product.imageName"
      />
      <div class="w-2/3 p-4">
        <h1 class="text-gray-900 font-bold text-2xl">
          {{ product.prodName }}
        </h1>
        <div class="flex item-center justify-between">
          <p class="mt-2 font-semibold text-gray-600 text-sm">
            {{ product.brands.brandName }}
          </p>

          <h1 class="text-gray-700 font-bold text-xl">
            {{
              product.price.toLocaleString("en-US", {
                style: "currency",
                currency: "USD",
              })
            }}
          </h1>
        </div>
        <p class="mt-2 text-gray-600 text-sm max-h-28 h-28 overflow-auto">
          {{ product.prodDescription }}
        </p>
        <div class="flex item-center justify-between mt-3">
          <h1 class="text-gray-700 font-bold text-xl">
            <span class="text-xl text-black font-medium flex flex-row">
              <div
                class=""
                v-for="eachColor in product.productColor"
                v-bind:key="eachColor.colorId"
              >
                <div>
                  <span
                    class="border border-black w-6 h-6 block cursor-pointer ml-1"
                    :style="{ 'background-color': eachColor.colorValue }"
                  ></span>
                </div>
              </div>
            </span>
          </h1>
          <div class="mt-2 font-semibold text-gray-600 text-sm">
            Date : {{ product.prodManufactured }}
          </div>
        </div>
        <div class="flex item-center justify-around mt-3">
          <button
            class="justify-center w-full rounded-md border border-transparent border-black px-4 py-2 bg-blue-200 text-lg leading-6 font-semibold text-black shadow-sm hover:bg-blue-300 focus:outline-none focus:border-blue-700 focus:shadow-outline-red transition ease-in-out duration-150 sm:leading-5 mx-2"
            @click="gotoEditPage"
          >
            edit
          </button>
          <button
            class="inline-flex justify-center w-full rounded-md underline border-2 border-transparent border-gray-300 px-4 py-2 bg-white text-base leading-6 font-semibold text-red-600 shadow-sm hover:bg-red-100 hover:border-red-300 focus:outline-none focus:border-red-700 focus:shadow-outline-red transition ease-in-out duration-150 sm:leading-5 mx-2"
            @click="toggleDelete"
          >
            delete
          </button>
        </div>
      </div>
    </div>

    <!--Modal-->
    <div>
      <base-modal
        v-if="modalDelete"
        bgcolor="#FEE2E2"
        @close="toggleDelete"
        title="Delete Product"
      >
        <p class="text-sm leading-5 text-black">
          This product will be permanently deleted from this store Are you sure
          you want to
          <span class="font-bold text-red-600">Delete</span>
          this product? All of your data will be permanently removed.
        </p>
        <template v-slot:footer>
          <span class="flex w-full rounded-md shadow-sm sm:ml-3 sm:w-auto">
            <button
              type="button"
              @click="deleteReview(product.prodCode)"
              class="inline-flex justify-center w-full rounded-md border border-transparent px-4 py-2 bg-red-600 text-base leading-6 font-medium text-white shadow-sm hover:bg-red-500 focus:outline-none focus:border-red-700 focus:shadow-outline-red transition ease-in-out duration-150 sm:text-sm sm:leading-5"
            >
              Confirm Delete
            </button>
          </span>
        </template>
      </base-modal>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    product: {
      default: "",
    },
  },
  data() {
    return {
      modalDelete: false,
    };
  },

  methods: {
    toggleDelete() {
      this.modalDelete = !this.modalDelete;
    },
    gotoEditPage() {
      this.$router.push({
        name: "EditProduct",
        params: { id: this.product.prodCode },
      });
    },
    deleteReview(id) {
      console.log(id);
      axios
        .delete(
          `http://172.22.0.3:8080/images/delete/${this.product.imageName}`
        )
        .then((response) => {
          return response.data;
        })
        .then(() => {
          axios.delete(`http://172.22.0.3:8080/products/delete/${id}`);
        })
        .then(this.toggleDelete())

        .then(this.$emit("deleteReview", id));
    },
  },
  computed: {},
};
</script>

