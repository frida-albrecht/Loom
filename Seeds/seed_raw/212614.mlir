module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.921600e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %1 = tosa.tanh %0 : (tensor<7xf32>) -> tensor<7xf32>
    %2 = tosa.reciprocal %1 : (tensor<7xf32>) -> tensor<7xf32>
    %3 = tosa.abs %2 : (tensor<7xf32>) -> tensor<7xf32>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<7xf32>) -> tensor<i32>
    %5 = tosa.arithmetic_right_shift %4, %4 {round = false} : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %6 = tosa.floor %2 : (tensor<7xf32>) -> tensor<7xf32>
    %7 = tosa.reciprocal %3 : (tensor<7xf32>) -> tensor<7xf32>
    %8 = tosa.maximum %6, %7 : (tensor<7xf32>, tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %5 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

