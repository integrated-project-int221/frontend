<template>
  <div class="teammate">
    <div class="container">
      <h1>Team Member</h1>
    </div>
    <!-- component -->

    <div class="container mx-auto flex flex-wrap my-8 justify-center">
      <div class="grid sm:grid-cols-2 md:grid-cols-3 gap-4">
        <team-member-card name="Tanawat Srijarattanon" position="#Frontend">
          <template v-slot:images>
            <img
              class="max-w-sm w-full max-h-80 object-cover object-center"
              src="../assets/TeamGuy.jpg"
              alt="Tanawat Srijarattanon"
            />
          </template>
        </team-member-card>
        <team-member-card name="Pantavit Hengnalen" position="#Backend">
          <template v-slot:images>
            <img
              class="max-w-sm w-full max-h-80 object-cover object-center"
              src="../assets/Teamtien.jpg"
              alt="Pantavit Hengnalen"
            />
          </template>
          <template v-slot:morePosition><span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold  mr-2">Dev-ops</span></template>
        </team-member-card>

        <team-member-card name="Supakit Teppong" position="#Database">
          <template v-slot:images>
            <img
              class="max-w-sm w-full max-h-80 object-cover object-center"
              src="../assets/TeamTar.jpg"
              alt="Supakit Teppong"
            />
            
          </template>
            
          <template v-slot:morePosition><span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold  mr-2">Dev-ops</span></template>
        </team-member-card>
      </div>
    </div>
  </div>
</template>

<script>
import TeamMemberCard from "../components/TeamMemberCard.vue";

export default {
  components: {
    TeamMemberCard,
  },
};
</script>

