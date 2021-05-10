<template>
  <div
    class="flex flex-row bg-white rounded-lg border border-gray-200 shadow-lg py-6 px-8"
  >
    <!--upload photo-->
    <div class="md:flex items-center justify-center py-6 px-8">
      <div class="upload-photo">
        <div class="container border p-2 mt-3">
          <template v-if="!preview">
            <label
              class="border-2 border-black h-64 w-64 flex flex-col items-center justify-center cursor-pointer rounded-lg shadow-lg"
            >
              <svg
                class="w-8 h-8"
                fill="currentColor"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
              >
                <path
                  d="M16.88 9.1A4 4 0 0 1 16 17H5a5 5 0 0 1-1-9.9V7a3 3 0 0 1 4.52-2.59A4.98 4.98 0 0 1 17 8c0 .38-.04.74-.12 1.1zM11 11h3l-4-4-4 4h3v3h2v-3z"
                />
              </svg>
              <span class="mt-2 text-base font-medium leading-normal"
                >Upload a Image</span
              >
              <input
                type="file"
                accept="image/*"
                @change="previewImage"
                class="hidden form-control-file"
                id="my-file"
              />
            </label>
            <p
              v-show="checkValidate.errorImage"
              class="text-red-600 text-base font-medium italic"
            >
              Please upload Image.
            </p>
          </template>

          <template v-if="preview">
            <div
              class="border-2 h-64 w-64 border-blue-800 rounded-lg shadow-lg"
            >
              <span>
                <img
                  :src="preview"
                  class="w-full h-full flex items-center justify-center object-cover object-center m-auto rounded-lg"
                />
              </span>
            </div>
            <label
              class="flex flex-col items-center px-3 py-1 mt-2 bg-white text-blue rounded-lg shadow-lg tracking-wide border border-blue cursor-pointer hover:bg-blue hover:text-white"
            >
              <svg
                class="w-6 h-6"
                fill="currentColor"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
              >
                <path
                  d="M16.88 9.1A4 4 0 0 1 16 17H5a5 5 0 0 1-1-9.9V7a3 3 0 0 1 4.52-2.59A4.98 4.98 0 0 1 17 8c0 .38-.04.74-.12 1.1zM11 11h3l-4-4-4 4h3v3h2v-3z"
                />
              </svg>
              <span class="text-sm leading-normal">Upload new Image</span>
              <input
                type="file"
                accept="image/*"
                @change="previewImage"
                class="hidden form-control-file"
                id="my-file"
              />
            </label>

          </template>
        </div>
      </div>
    </div>
    <!--form input-->
    <form @submit.prevent="submit" class="">
      <div class="">
        <label class="block text-base font-medium text-black" for="name"
          >Name</label
        >
        <input
          class="w-full px-3 py-2 text-gray-700 bg-gray-200 rounded"
          id="name"
          name="name"
          maxlength="40"
          v-model="formInputValue.prodName"
          @change="changeNameImage()"
          type="text"
          placeholder="Your Name"
        />
        <p
          v-show="checkValidate.errorName"
          class="text-red-600 text-base font-medium italic"
        >
          Please input Name. 
        </p>
        <p
          v-show="checkDuplicateName"
          class="text-red-600 text-base font-medium italic"
        >
          !! Duplicate Name.
        </p>
      </div>
      <div class="mt-2">
        <label class="block text-base font-medium text-black" for="brand"
          >Brands</label
        >
        <select
          id="brand"
          class="w-full px-2 py-2 text-gray-700 bg-gray-200 rounded"
          v-model="formInputValue.brands"
        >
          <option value="" hidden disabled selected>Please select one</option>
          <option
            v-for="option in brandsResults"
            :value="option"
            :key="option"
            :selected="option === formInputValue.brands"
          >
            {{ option.brandName }}
          </option>
        </select>
        <p
          v-show="checkValidate.errorBrands"
          class="text-red-600 text-base font-medium italic"
        >
          Please select one.
        </p>
      </div>
      <div class="mt-2">
        <label class="block text-base font-medium text-black" for=""
          >Color(s)</label
        >
        <div class="flex flex-row">
          <label
            v-for="option in colorsResults"
            :key="option"
            class="check-color flex p-1 border-2 border-gray-200 hover:border-black rounded-full transition ease-in duration-300 w-8 h-8 bg-blue-900 rounded-full justify-center items-center"
            :for="option.id"
            :style="{ 'background-color': option.colorValue }"
          >
            <input
              v-model="formInputValue.productColor"
              type="checkbox"
              :id="option.id"
              :value="option"
            />
          </label>
        </div>
        <p
          v-show="checkValidate.errorColors"
          class="text-red-600 text-base font-medium italic"
        >
          Please choose color(s).
        </p>
      </div>
      <div class="flex flex-row">
        <div class="mt-2 w-1/2 pr-1">
          <label class="block text-base font-medium text-black" for="cus_email"
            >Date</label
          >
          <input
            class="w-full px-2 py-2 text-gray-700 bg-gray-200 rounded"
            type="date"
            placeholder="Date"
            v-model="formInputValue.prodManufactured"
          />
          <p
            v-show="checkValidate.errorProdManufactured"
            class="text-red-600 text-base font-medium italic"
          >
            Please input Date.
          </p>
        </div>

        <div class="mt-2 -mx-1 pl-1 w-1/2">
          <label class="block text-base font-medium text-black" for="cus_email"
            >Price</label
          >
          <div class="flex flex-row">
            <span
              class="flex items-center bg-grey-lighter rounded rounded-r-none px-3 font-bold text-grey-darker"
              >$</span
            >
            <input
              class="w-full px-2 py-2 text-gray-700 bg-gray-200 rounded text-right"
              v-model.number="formInputValue.price"
              type="number"
              name="number"
              id="number"
              step="0.01"
              placeholder="Price"
            />
          </div>
          <p
            v-show="checkValidate.errorPrice"
            class="text-red-600 text-base font-medium italic"
          >
            Price between 0-1,000,000.
          </p>
        </div>
      </div>

      <div class="mt-4">
        <label class="block text-base font-medium text-black" for="cus_name"
          >Description</label
        >
        <textarea
          class="w-full px-2 py-2 text-gray-700 bg-gray-200 rounded"
          rows="4"
          v-model="formInputValue.prodDescription"
          placeholder="Description"
        ></textarea>
        <p
          v-show="checkValidate.errorDescription"
          class="text-red-600 text-base font-medium italic"
        >
          Please input Description.
        </p>
      </div>
      <div class="mt-4">
        <button
          class="px-4 py-1 w-full text-white font-light tracking-wider bg-gray-900 rounded"
        >
          Submit
        </button>
      </div>
    </form>
  </div>

</template>

<script>
export default {
  props: {
    testEditData: {
      type: Object,
    },
    imgUrlValue: {},
  },
  data() {
    return {
      colorsResults: [],
      brandsResults: [],
      productsResults: [],
      formInputValue: {
        prodName: "",
        prodDescription: "",
        price: 0.0,
        prodManufactured: "",
        brands: "",
        productColor: [],
        imageName: "",
        imageObj: "",
        // url: `${process.env.VUE_APP_REST_API}`
      },
      preview: null,
      //check validate
      checkValidate: {
        errorName: false,
        errorDescription: false,
        errorPrice: false,
        errorProdManufactured: false,
        errorBrands: false,
        errorColors: false,
        errorImage: false,
      },
      //
      nameImageFromProduct: "",
      nameImageInput: "",
      checkDuplicateName: "",
      //
    };
  },
  methods: {
    formValidate() {
      let count = 0;
      for (let index = 0; index < this.productsResults.length; index++) {
        const allProductName = this.productsResults[index].prodName;

        if (this.formInputValue.prodName == allProductName) {
          if(this.formInputValue.prodName == this.checkDuplicateName){
            
            count -= 1;
          }
          count += 1;
          
        }
      }
      this.checkDuplicateName = count > 0 ? true : false;
      if (this.formInputValue.prodName === "") {
        this.checkValidate.errorName = true;
      } else {
        this.checkValidate.errorName = false;
      }

      if (
        this.formInputValue.prodDescription === "" ||
        this.formInputValue.prodDescription > 1000
      ) {
        this.checkValidate.errorDescription = true;
      } else this.checkValidate.errorDescription = false;

      this.checkValidate.errorProdManufactured =
        this.formInputValue.prodManufactured === "" ? true : false;

      if (
        this.formInputValue.price <= 0 ||
        this.formInputValue.price > 1000000
      ) {
        this.checkValidate.errorPrice = true;
      } else this.checkValidate.errorPrice = false;

      this.checkValidate.errorBrands =
        this.formInputValue.brands === "" ? true : false;

      this.checkValidate.errorColors =
        this.formInputValue.productColor == "" ? true : false;

      this.checkValidate.errorImage = this.nameImageInput === "" ? true : false;
    },

    changeNameImage() {
      this.nameImagefromProduct = this.formInputValue.prodName;

      return this.nameImagefromProduct;
    },
    previewImage(event) {
      this.formInputValue.imageObj = event.target.files[0];


      var input = event.target;
      if (input.files) {
        var reader = new FileReader();
        reader.onload = (e) => {
          this.preview = e.target.result;

        };
        this.nameImageInput = input.files[0].name;
        reader.readAsDataURL(input.files[0]);
      }
    },

    submit() {
      this.formValidate();
      if (
        this.checkValidate.errorName ||
        this.checkValidate.errorDescription ||
        this.checkValidate.errorProdManufactured ||
        this.checkValidate.errorPrice ||
        this.checkValidate.errorBrands ||
        this.checkValidate.errorColors
      ) {
        console.log("Input error");
      } else {
        let sendValue = this.formInputValue
        if(this.nameImageInput == ""){
          sendValue.imageName = this.formInputValue.imageName
        }else{
          sendValue.imageName = this.formInputValue.prodName + this.nameImageInput;
        }
        this.$emit("form-submit", sendValue);
      }
    },

    async fetchColorsResult() {
      try {
        const res = await fetch(this.url+"colors");
        const data = await res.json();
        return data;
      } catch (error) {
        console.log(error);
      }
    },
    async fetchBrandsResult() {
      try {
        const res = await fetch(this.url+"brands");
        const data = await res.json();
        return data;
      } catch (error) {
        console.log(error);
      }
    },
    async fetchAllProductResult() {
      const res = await fetch(this.url+"products/items");
      const data = await res.json();
      return data;
    },
  },
  async created() {
    try {
      this.colorsResults = await this.fetchColorsResult();
      this.brandsResults = await this.fetchBrandsResult();
      this.productsResults = await this.fetchAllProductResult();
      (this.formInputValue.prodName = this.testEditData?.prodName || ""),
        (this.formInputValue.prodDescription =
          this.testEditData?.prodDescription || ""),
        (this.formInputValue.price = this.testEditData?.price || 0.0),
        (this.formInputValue.prodManufactured =
          this.testEditData?.prodManufactured || ""),
        (this.formInputValue.brands = this.testEditData?.brands || ""),
        (this.formInputValue.productColor =
          this.testEditData?.productColor || []),
        (this.formInputValue.imageName = this.testEditData?.imageName || ""),
        (this.formInputValue.imageObj = "");

      this.checkDuplicateName = this.testEditData?.prodName || "";
      this.preview = this.imgUrlValue;
    } catch (error) {
      console.log(error);
    }
  },
};
</script>

<style scoped>
input[type="checkbox"] {
  position: relative;
  cursor: pointer;
}
input[type="checkbox"]:before {
  content: "";
  display: flex;
  position: absolute;
  width: 12px;
  height: 12px;
  border: 2px;
  border-radius: 3px;
  background-color: white;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
input[type="checkbox"]:checked:after {
  content: "";
  display: block;
  width: 5px;
  height: 10px;
  border: solid black;
  border-width: 0 2px 2px 0;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  transform: rotate(45deg);
  position: absolute;
  left: 4px;
}
</style>
