<template>
  <div class="container border border-black">
    <div class="m-4">
      <h1 class="font-bold">Edit Product</h1>
    </div>
    <div>

    </div>

    <!--Add new Product-->
    <form-input
      :testEditData="productByid"
      :imgUrlValue="imgURL"
      @form-submit="editArray"
    >
    </form-input>

    <base-modal
      v-if="modalOpen"
      @close="toggleModal"
      title="Edit Product Completed"
      bgcolor="#D3FAFF"
    >
      <span class="text-base leading-5 text-gray-700">
        This product was
        <span class="font-bold text-blue-600 text-lg">Edit</span>
        <p>
          Check product please go to
          <span class="font-bold text-blue-600 text-lg">Home page.</span>
        </p>
      </span>
    </base-modal>
  </div>
</template>

<script>
import FormInput from "../components/FormInput.vue";
import axios from "axios";

export default {
  props: ["id"],
  components: { FormInput },
  data() {
    return {
      productByid: {},
      imgURL: "",
      modalOpen: false,
<<<<<<< HEAD
=======
      url: `${process.env.VUE_APP_REST_API}`
>>>>>>> 83f4f38685f067da629b460db81b4358f3b7e8fe
    };
  },

  methods: {
    toggleModal() {
      this.modalOpen = !this.modalOpen;
    },

    editArray(editValue) {
      if (editValue.imageObj == "") {
        axios
          .put(
<<<<<<< HEAD
            `http://207.46.228.91:3000/images/updatename/${this.id}/${editValue.prodName}`
=======
            `http://207.46.228.91/restapi/images/updatename/${this.id}/${editValue.prodName}`
>>>>>>> 83f4f38685f067da629b460db81b4358f3b7e8fe
          )
          .then(() => {
            console.log("this images was send then post product");
          });
      } else {
        const fd = new FormData();
        fd.append("File", editValue.imageObj, editValue.imageObj.name);
        axios
          .put(
<<<<<<< HEAD
            `http://207.46.228.91:3000/images/update/${editValue.prodName}/${this.productByid.imageName}`,
=======
            `http://207.46.228.91/restapi/images/update/${editValue.prodName}/${this.productByid.imageName}`,
>>>>>>> 83f4f38685f067da629b460db81b4358f3b7e8fe
            fd
          )
          .then(() => {
            console.log(editValue.imageName);
            console.log(this.productByid.imageName);
          });
      }
      axios
<<<<<<< HEAD
        .put(`http://207.46.228.91:3000/products/update/${this.id}`, editValue)
=======
        .put(`http://207.46.228.91/restapi/products/update/${this.id}`, editValue)
>>>>>>> 83f4f38685f067da629b460db81b4358f3b7e8fe
        .then((response) => {
          console.log(response);
        })
        .then(() => {
          this.toggleModal()
        });

    },
    async fetchProductResult() {
      const res = await fetch(
<<<<<<< HEAD
        `http://207.46.228.91:3000/products/item/${this.id}`
=======
        `http://207.46.228.91/restapi/products/item/${this.id}`
>>>>>>> 83f4f38685f067da629b460db81b4358f3b7e8fe
      );
      const data = await res.json();
      return data;
    },
  },
  async created() {
    this.productByid = await this.fetchProductResult();
<<<<<<< HEAD
    this.imgURL = `http://207.46.228.91:3000/images/get/${this.productByid.imageName}`;
=======
    this.imgURL = `http://207.46.228.91/restapi/images/get/${this.productByid.imageName}`;
>>>>>>> 83f4f38685f067da629b460db81b4358f3b7e8fe
  },
};
</script>
