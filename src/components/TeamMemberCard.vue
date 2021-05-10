<template>
  <div
    class="max-w-sm rounded overflow-hidden shadow-xl cursor-pointer border-2 hover:border-gray-600"
  >
    <slot name="images"></slot>
    <div class="px-6 py-4">
      <div class="font-bold text-xl mb-2">{{ name }}</div>
      <p class="text-base">
        {{ description }}
      </p>
    </div>
    <div class="px-6 py-4 text-center">
      <span
        class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold mr-2"
        >{{ position }}</span
      >
      <slot name="morePosition"></slot>
    </div>
  </div>
</template>

<script>
export default {
  props: ["name", "position", "description", "src"],
};
</script>
