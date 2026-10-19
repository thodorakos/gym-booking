<script setup lang="ts">
import { ref } from 'vue';
import Carousel from 'primevue/carousel';

const testimonials = ref([
    {
        name: 'Γιώργος Π.',
        role: 'Professional Athlete',
        quote: 'Η απόδοσή μου στο γήπεδο άλλαξε δραματικά μετά από 3 μήνες. Η προσέγγιση είναι επιστημονική και μετρήσιμη.',
        result: '+15% Ταχύτητα'
    },
    {
        name: 'Μαρία Κ.',
        role: 'Ελεύθερη Επαγγελματίας',
        quote: 'Δεν είχα χρόνο για χάσιμο. Το πλάνο προσαρμόστηκε στο πρόγραμμα μου και τα αποτελέσματα ήρθαν πιο γρήγορα από ότι περίμενα.',
        result: '-8kg Λίπος'
    },
    {
        name: 'Δημήτρης Α.',
        role: 'Marathon Runner',
        quote: 'Η αποκατάσταση του γόνατος ήταν πλήρης. Τώρα τρέχω χωρίς πόνο και με καλύτερη τεχνική.',
        result: 'Full Recovery'
    },
    {
        name: 'Ελένη Σ.',
        role: 'Fitness Enthusiast',
        quote: 'Ο χώρος και η κοινότητα σε εμπνέουν να προσπαθείς περισσότερο. Δεν είναι απλά γυμναστήριο.',
        result: 'Consistency 100%'
    }
]);

const responsiveOptions = ref([
    {
        breakpoint: '1024px',
        numVisible: 2,
        numScroll: 1
    },
    {
        breakpoint: '768px',
        numVisible: 1,
        numScroll: 1
    }
]);
</script>

<template>
    <section class="py-24 bg-zinc-950 border-y border-zinc-900 overflow-hidden">
        <div class="container mx-auto px-6">
            <div class="mb-16 md:mb-24 text-center">
                <h2 class="text-3xl font-black uppercase tracking-tighter md:text-5xl text-white">
                    WHAT THEY <span class="text-swiss-orange">SAY</span>
                </h2>
                <div class="mt-4 h-1 w-24 bg-swiss-orange mx-auto"></div>
            </div>

            <Carousel 
                :value="testimonials" 
                :numVisible="3" 
                :numScroll="1" 
                :responsiveOptions="responsiveOptions" 
                circular
                :autoplayInterval="5000"
                class="custom-carousel"
            >
                <template #item="slotProps">
                    <div class="mx-3 h-full">
                        <div class="bg-zinc-900 border border-zinc-800 p-8 rounded-2xl h-full flex flex-col relative group hover:border-swiss-orange/50 transition-colors duration-300">
                            <!-- Quote Icon -->
                            <div class="absolute top-6 right-6 text-zinc-800 group-hover:text-zinc-700 transition-colors">
                                <i class="pi pi-quote-right text-4xl"></i>
                            </div>

                            <p class="text-zinc-400 mb-6 italic leading-relaxed relative z-10 flex-grow">
                                "{{ slotProps.data.quote }}"
                            </p>

                            <div class="mt-auto border-t border-zinc-800 pt-6">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <h4 class="text-white font-bold tracking-tight">{{ slotProps.data.name }}</h4>
                                        <p class="text-xs text-zinc-500 uppercase tracking-wider font-semibold mt-1">{{ slotProps.data.role }}</p>
                                    </div>
                                    <div class="bg-zinc-950 px-3 py-1 rounded border border-zinc-800">
                                        <span class="text-swiss-orange font-bold text-xs">{{ slotProps.data.result }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </Carousel>
        </div>
    </section>
</template>

<style>
/* PrimeVue Carousel Customization */
.custom-carousel .p-carousel-indicators {
    @apply mt-8 gap-2;
}
.custom-carousel .p-carousel-indicator-button {
    @apply w-2 h-2 rounded-full bg-zinc-800 hover:bg-zinc-600 transition-colors !important;
}
.custom-carousel .p-carousel-indicator.p-highlight .p-carousel-indicator-button {
    @apply bg-swiss-orange w-6 !important;
}
</style>