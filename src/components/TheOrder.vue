<template>
  <div class="order-body">
    <ext-params :extParams="order.extParams" />
    <order-items :specs="specs" :orderitems="order.orderItems" />
  </div>
</template>

<script>
import ExtParams from "./ExtParams.vue";
import OrderItems from "./OrderItems.vue";
export default {
  components: { ExtParams, OrderItems },
  name: "TheOrder",
  props: {
    specs: Array,
    order: Object,
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.order-body {
  padding: 10px;
  margin: 0;
  background: blue;
  color: white;
}
</style>