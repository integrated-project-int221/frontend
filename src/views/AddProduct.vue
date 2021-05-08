<template>
  <div class="container">
    <div class="m-4">
      <h1 class="font-bold">Add product</h1>
    </div>
    <!--Add new Product-->
    <form-input @form-submit="addProduct"> </form-input>

    <base-modal
      v-if="modalOpen"
      @close="toggleModal"
      title="Add Product Completed"
      bgcolor="#D3FFE3"
    >
      <span class="text-base leading-5 text-gray-700">
        This product was add to
        <span class="font-bold text-green-600 text-lg">Product list</span>
        <p>
          Check product please go to
          <span class="font-bold text-green-600 text-lg">Home page.</span>
        </p>
      </span>
    </base-modal>
  </div>
</template>

<script>
import FormInput from "../components/FormInput.vue";
import axios from "axios";

export default {
  components: { FormInput },
  data() {
    return {
      modalOpen: false,
    };
  },
  methods: {
    toggleModal() {
      this.modalOpen = !this.modalOpen;
    },
    addProduct(newProduct) {
      const fd = new FormData();
      fd.append("File", newProduct.imageObj, newProduct.imageObj.name);

      axios
        .post(
          `http://172.22.0.3:3000/images/upload/${newProduct.prodName}`,
          fd
        )
        .then((res) => {
          console.log(res);
          console.log(newProduct.prodName);
          console.log("this images was send then post product");
        });

      axios
        .post("http://172.22.0.3:3000/products/add", newProduct)
        .then((response) => {
          console.log(response);
          console.log("this product added");
        })
        .then(() => {
          this.toggleModal();
        });
      // .then();
      // window.location.href = "http://localhost:8081/"
      // this.$router.push("/")
    },
  },
};
</script>
