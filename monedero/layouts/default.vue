<template>
  <a-layout
    id="components-layout-demo-custom-trigger"
    style="min-height: 100vh"
  >
    <a-layout-sider v-model="collapsed" :trigger="null" collapsible>
      <div class="logo" />
      <a-menu theme="dark" mode="inline" :default-selected-keys="['home1']">
        <a-menu-item key="home1">
          <NuxtLink to="/">
            <a-icon type="home" />
            <span>Inicio</span>
          </NuxtLink>
        </a-menu-item>
        <a-sub-menu key="wallet1">
          <span slot="title"> 
            <a-icon type="wallet"/>
            <span>Billetera</span>
          </span>
          <a-menu-item key="wallet11">
            <NuxtLink to="/wallet/balance">Saldo</NuxtLink>
          </a-menu-item>
          <a-menu-item key="wallet12">
            <NuxtLink to="/wallet/recharge">Recargar</NuxtLink>
          </a-menu-item>
        </a-sub-menu>
        <a-sub-menu key="buy1">
          <span slot="title">
            <a-icon type="shopping" />
            <span>Compra</span>
          </span>
          <a-menu-item key="buy11">
            <NuxtLink to="/buy/payment">Pago</NuxtLink>
          </a-menu-item>
        </a-sub-menu>
        <a-menu-item key="client1">
          <NuxtLink to="/clients">
            <a-icon type="user" />
            <span>Clientes</span>
          </NuxtLink>
        </a-menu-item>
      </a-menu>
    </a-layout-sider>
    <a-layout>
      <a-layout-header style="background: #fff; padding: 0">
        <a-icon
          class="trigger"
          :type="collapsed ? 'menu-unfold' : 'menu-fold'"
          @click="() => (collapsed = !collapsed)"
        />
      </a-layout-header>
      <a-layout-content
        :style="{
          margin: '24px 16px',
          padding: '24px',
          background: '#fff',
          minHeight: '280px',
        }"
      >
        <Nuxt />
      </a-layout-content>
      <a-layout-footer style="text-align: center">
        Prueba de Epayco | Created by José Artigas
      </a-layout-footer>
    </a-layout>
  </a-layout>
</template>
<script>


export default {

  data() {
    return {
      collapsed: false,
      
    }
  },
  methods: {

  }
}
</script>
<style>
#components-layout-demo-custom-trigger .trigger {
  font-size: 18px;
  line-height: 64px;
  padding: 0 24px;
  cursor: pointer;
  transition: color 0.3s;
}

#components-layout-demo-custom-trigger .trigger:hover {
  color: #1890ff;
}

#components-layout-demo-custom-trigger .logo {
  height: 32px;
  background: rgba(255, 255, 255, 0.2);
  margin: 16px;
}
</style>
