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
            `http://172.22.0.3:3000/images/updatename/${this.id}/${editValue.prodName}`
          )
          .then(() => {
            console.log("this images was send then post product");
          });
      } else {
        const fd = new FormData();
        fd.append("File", editValue.imageObj, editValue.imageObj.name);
        axios
          .put(
            `http://172.22.0.3:3000/images/update/${editValue.prodName}/${this.productByid.imageName}`,
            fd
          )
          .then(() => {
            console.log(editValue.imageName);
            console.log(this.productByid.imageName);
          });
      }
      axios
        .put(`http://172.22.0.3:3000/products/update/${this.id}`, editValue)
        .then((response) => {
          console.log(response);
        })
        .then(() => {
          this.toggleModal()
        });

    },
    async fetchProductResult() {
      const res = await fetch(
        `http://172.22.0.3:3000/products/item/${this.id}`
      );
      const data = await res.json();
      return data;
    },
  },
  async created() {
    this.productByid = await this.fetchProductResult();
    this.imgURL = `http://172.22.0.3:3000/images/get/${this.productByid.imageName}`;
  },
};
</script>
