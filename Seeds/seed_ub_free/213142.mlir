module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.258100e+02> : tensor<5x9x2xf32>}> : () -> tensor<5x9x2xf32>
    %1 = "tosa.const"() <{values = dense<53> : tensor<5x9xi32>}> : () -> tensor<5x9xi32>
    %2 = "tosa.const"() <{values = dense<-182> : tensor<5x9xi32>}> : () -> tensor<5x9xi32>
    %3 = tosa.tanh %0 : (tensor<5x9x2xf32>) -> tensor<5x9x2xf32>
    %4 = tosa.reduce_max %3 {axis = 1 : i32} : (tensor<5x9x2xf32>) -> tensor<5x1x2xf32>
    %5 = tosa.const_shape  {values = dense<[10, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.reshape %4, %5 : (tensor<5x1x2xf32>, !tosa.shape<2>) -> tensor<10x1xf32>
    %7 = tosa.intdiv %1, %2 : (tensor<5x9xi32>, tensor<5x9xi32>) -> tensor<5x9xi32>
    %8 = tosa.ceil %6 : (tensor<10x1xf32>) -> tensor<10x1xf32>
    %9 = tosa.add %8, %8 : (tensor<10x1xf32>, tensor<10x1xf32>) -> tensor<10x1xf32>
    %c0 = "tosa.const"() <{values = dense<1.0> : tensor<10x1xf32>}> : () -> tensor<10x1xf32>
    %s0 = tosa.maximum %8, %c0 : (tensor<10x1xf32>, tensor<10x1xf32>) -> tensor<10x1xf32>
    %10 = tosa.pow %9, %s0 : (tensor<10x1xf32>, tensor<10x1xf32>) -> tensor<10x1xf32>
    %cast = tensor.cast %7 : tensor<5x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<10x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}