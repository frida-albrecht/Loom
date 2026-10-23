module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-120> : tensor<10x6x10x9xi64>}> : () -> tensor<10x6x10x9xi64>
    %1 = "tosa.const"() <{values = dense<71> : tensor<1x1x10x9xi64>}> : () -> tensor<1x1x10x9xi64>
    %2 = "tosa.const"() <{values = dense<1.477300e+02> : tensor<1x2x1x2xf32>}> : () -> tensor<1x2x1x2xf32>
    %3 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<10x6x10x9xi64>, tensor<1x1x10x9xi64>) -> tensor<10x6x10x9xi64>
    %4 = tosa.reciprocal %2 : (tensor<1x2x1x2xf32>) -> tensor<1x2x1x2xf32>
    %5 = tosa.bitwise_or %3, %3 : (tensor<10x6x10x9xi64>, tensor<10x6x10x9xi64>) -> tensor<10x6x10x9xi64>
    %6 = tosa.const_shape  {values = dense<5400> : tensor<1xindex>} : () -> !tosa.shape<1>
    %7 = tosa.reshape %5, %6 : (tensor<10x6x10x9xi64>, !tosa.shape<1>) -> tensor<5400xi64>
    %8 = tosa.minimum %7, %7 : (tensor<5400xi64>, tensor<5400xi64>) -> tensor<5400xi64>
    %9 = tosa.argmax %8 {axis = 0 : i32} : (tensor<5400xi64>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<1x2x1x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

