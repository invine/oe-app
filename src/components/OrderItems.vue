<template>
  <div class="order-items">
    <div v-if="drawOrderItem">
      <h2>Order Items</h2>
      <ul>
        <li v-for="item in orderitems" v-bind:key="item.id">
          <order-item
            :orderitem="item"
            :specs="specs"
            :parentSpecId="parentSpecId"
            v-on:removeOrderItem="removeOrderItem($event)"
          />
        </li>
      </ul>
    </div>
    <button v-on:click="addOrderItem">Add Order Item</button>
  </div>
</template>

<script>
import { uuid } from 'vue-uuid';
export default {
  components: {
    OrderItem: () => import("./OrderItem.vue"),
  },
  props: {
    specs: Array,
    orderitems: Array,
    parentSpecId: String,
  },
  name: "OrderItems",
  computed: {
    drawOrderItem: function () {
      return this.orderitems && this.orderitems.length > 0;
    },
  },
  methods: {
    addOrderItem: function () {
      this.orderitems.push({
        id: uuid.v4(),
        action: "add",
        orderItems: [],
        extParams: [],
        product: {
          productSpecification: {},
          characteristic: [],
        },
      });
    },
    removeOrderItem: function (item) {
      this.orderitems.splice(this.orderitems.indexOf(item), 1);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.order-items {
  padding: 10px;
  margin: 0;
  background: red;
  color: white;
}
</style>