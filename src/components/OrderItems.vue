<template>
  <div class="container px-4">
    <ul class="group-list px-0">
      <li
        class="group-list-item"
        v-for="item in parent.orderItem"
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
    <div class="d-grid gap-2 p-0">
      <!-- <button
        class="btn btn-outline-link"
        v-if="!parentSpecId"
        v-on:click="addOrderItem"
      >
        Add Order Item
      </button> -->
      <button class="btn btn-outline-link px-2" v-on:click="addOrderItem">
        <i class="bi bi-plus-circle" style="font-size: 2rem"></i>
      </button>
    </div>
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
    // orderitems: Array,
    parent: Object,
    parentSpecId: String,
  },
  name: "OrderItems",
  methods: {
    addOrderItem: function () {
      if (!this.parent.orderItem) {
        this.parent.orderItem = [];
      }
      this.parent.orderItem.push({
        id: uuid.v4(),
        action: "add",
        orderItem: null,
        extParams: [],
        product: {
          productSpecification: {},
          characteristic: [],
        },
      });
    },
    removeOrderItem: function (item) {
      this.parent.orderItem.splice(this.parent.orderItem.indexOf(item), 1);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
