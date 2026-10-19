<script setup lang="ts">
import { onMounted, ref } from 'vue';

const metrics = [
  { label: 'Ενεργοί αθλητές', target: 84, color: 'text-white' },
  { label: 'Συνεδρίες / μήνα', target: 320, color: 'text-swiss-orange' },
  { label: 'Μέση συνέπεια', target: 93, suffix: '%', color: 'text-white' }
];

const values = ref(metrics.map(m => m.target));

onMounted(() => {
  // Logic mostly for fallback if AnimateOnScroll doesn't trigger custom JS,
  // but we leave this here or remove if we want pure CSS animation for the text reveal.
  // Actually, let's keep the counter logic as is, but maybe trigger it with intersection observer?
  // Use the directive to determine "enter" state if possible.
  
  // For now, let's just animate the container entrance.
});
</script>

<template>
  <section class="border-b border-zinc-800 bg-transparent py-20 text-white overflow-hidden relative z-10">
    <div class="container mx-auto grid max-w-7xl grid-cols-1 gap-12 px-6 md:grid-cols-3">
      <div
        v-for="(metric, index) in metrics"
        :key="metric.label"
        v-animateonscroll="{ enterClass: 'animate-in fade-in slide-in-from-bottom-10 duration-700 ease-out', leaveClass: 'opacity-0' }"
        :class="`delay-${ index * 100 }`"
        class="group flex flex-col items-center justify-center text-center opacity-0"
      >
        <p class="text-6xl font-black tracking-tighter transition-all duration-300 group-hover:scale-110 group-hover:drop-shadow-[0_0_15px_rgba(255,77,0,0.5)] cursor-default" :class="metric.color">
          {{ values[index] }}{{ metric.suffix || '' }}
        </p>
        <p class="mt-4 text-xs font-bold uppercase tracking-[0.2em] text-zinc-500 transition-colors duration-300 group-hover:text-white">
          {{ metric.label }}
        </p>
      </div>
    </div>
  </section>
</template>
