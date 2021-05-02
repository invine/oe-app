<template>
  <div>
    <order-items class="block" :specs="specs" :orderitems="order.orderItems" />
    <ext-params class="block" :extParams="order.extParams" />
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
</style>