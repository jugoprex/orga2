sched_task_offset:
    dd 0xFFFFFFFF
sched_task_selector:
    dw 0xFFFF

global _isr32

_isr32:
    pushad                                      ;guarda estados
    call pic_finish1                            ;’’estoy atendiendo la interrupcion’
    call sched_next_task                        ;llama al esquedulador para atender la tarea

    str cx                                      ;store task register
    cmp ax, cx                                  ;si el task a saltar es el mismo que el task actual,
    je .fin                                     ;ir a fin

    mov word [sched_task_selector], ax          ;else hacer el cambio de task
    jmp far [sched_task_offset]                 ;toma 48 bits a partir de la etiqueta que le pasamos de parametro


.fin:
    popad
    iret                                        ;retorna de la interrupcion :D
