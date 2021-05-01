<template>
  <div class="box">
    <div class="block" v-if="drawOrderItem">
      <div class="subtitle" v-if="!parentSpecId">Order Items</div>
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
    <button class="block button is-primary is-small" v-on:click="addOrderItem">
      Add Order Item
    </button>
  </div>
</template>

<script>
import { uuid } from "vue-uuid";
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
@import "https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css";
</style>