<template>
  <div class="order-header">
    <h1>Table Order Entry</h1>
    <select>
      <option>3</option>
      <option>2</option>
    </select>
    <select>
      <option>Product Order</option>
      <option>Service Order</option>
    </select>
    <button v-on:click="clearOrder">Clear</button>
  </div>
</template>

<script>
export default {
  name: "TheHeader",
  props: {},
  methods: {
    clearOrder: function () {
      this.$emit("clearOrder");
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.order-header {
  padding: 10px;
  margin: 0;
  background: black;
  color: white;
}
</style>