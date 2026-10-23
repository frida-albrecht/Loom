module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.832200e+02> : tensor<9x8x3xf32>}> : () -> tensor<9x8x3xf32>
    %1 = "tosa.const"() <{values = dense<-106> : tensor<10xi32>}> : () -> tensor<10xi32>
    %2 = "tosa.const"() <{values = dense<-57> : tensor<10xi32>}> : () -> tensor<10xi32>
    %3 = tosa.floor %0 : (tensor<9x8x3xf32>) -> tensor<9x8x3xf32>
    %4 = tosa.const_shape  {values = dense<[3, 1, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.tile %3, %4 : (tensor<9x8x3xf32>, !tosa.shape<3>) -> tensor<27x8x3xf32>
    %6 = tosa.intdiv %1, %2 : (tensor<10xi32>, tensor<10xi32>) -> tensor<10xi32>
    %7 = tosa.clz %6 : (tensor<10xi32>) -> tensor<10xi32>
    %8 = tosa.minimum %6, %6 : (tensor<10xi32>, tensor<10xi32>) -> tensor<10xi32>
    %9 = tosa.abs %7 : (tensor<10xi32>) -> tensor<10xi32>
    %10 = tosa.abs %9 : (tensor<10xi32>) -> tensor<10xi32>
    %cast = tensor.cast %5 : tensor<27x8x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<10xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<10xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

