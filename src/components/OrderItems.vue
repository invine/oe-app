<template>
  <div class="container px-4">
    <div class="d-grid gap-2 p-0">
      <button
        class="btn btn-outline-link mt-2"
        v-if="!parentSpecId"
        v-on:click="addOrderItem"
      >
        Add Order Item
      </button>
      <button
        class="btn btn-outline-link"
        v-if="parentSpecId"
        v-on:click="addOrderItem"
      >
        <i class="bi bi-plus-circle" style="font-size: 2rem"></i>
      </button>
    </div>
    <ul class="group-list py-2 ps-2">
      <li
        class="group-list-item"
        v-for="item in orderitems"
        v-bind:key="item.id"
      >
        <order-item
          :orderitem="item"
          :specs="specs"
          :parentSpecId="parentSpecId"
          v-on:removeOrderItem="removeOrderItem($event)"
        />
      </li>
    </ul>
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
</style>
