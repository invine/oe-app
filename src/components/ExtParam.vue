<template>
  <div class="block columns">
    <input
      class="input column"
      placeholder="Extended Parameter"
      v-model="extParam.name"
    />
    <input class="input column" placeholder="Value" v-model="extParam.value" />
    <button class="delete column" v-on:click="removeExtParam">x</button>
  </div>
</template>

<script>
export default {
  name: "ExtParam",
  props: {
    extParam: Object,
  },
  methods: {
    removeExtParam: function () {
      this.$emit("removeExtParam", this.extParam);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import "https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css";
</style>