module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-67> : tensor<5x10x5xi32>}> : () -> tensor<5x10x5xi32>
    %1 = "tosa.const"() <{values = dense<135> : tensor<5x10x5xi32>}> : () -> tensor<5x10x5xi32>
    %2 = "tosa.const"() <{values = dense<97.6299972> : tensor<7x2x1xf32>}> : () -> tensor<7x2x1xf32>
    %3 = tosa.minimum %0, %1 : (tensor<5x10x5xi32>, tensor<5x10x5xi32>) -> tensor<5x10x5xi32>
    %4 = tosa.reverse %3 {axis = 1 : i32} : (tensor<5x10x5xi32>) -> tensor<5x10x5xi32>
    %5 = tosa.bitwise_or %4, %4 : (tensor<5x10x5xi32>, tensor<5x10x5xi32>) -> tensor<5x10x5xi32>
    %6 = tosa.reciprocal %2 : (tensor<7x2x1xf32>) -> tensor<7x2x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<5x10x5xi32>}> : () -> tensor<5x10x5xi32>
    %c1 = "tosa.const"() <{values = dense<31> : tensor<5x10x5xi32>}> : () -> tensor<5x10x5xi32>
    %a1 = tosa.maximum %5, %c0 : (tensor<5x10x5xi32>, tensor<5x10x5xi32>) -> tensor<5x10x5xi32>
    %a2 = tosa.minimum %a1, %c1 : (tensor<5x10x5xi32>, tensor<5x10x5xi32>) -> tensor<5x10x5xi32>
    %7 = tosa.arithmetic_right_shift %5, %a2 {round = true} : (tensor<5x10x5xi32>, tensor<5x10x5xi32>) -> tensor<5x10x5xi32>
    %8 = tosa.abs %7 : (tensor<5x10x5xi32>) -> tensor<5x10x5xi32>
    %9 = tosa.tanh %6 : (tensor<7x2x1xf32>) -> tensor<7x2x1xf32>
    %10 = tosa.abs %6 : (tensor<7x2x1xf32>) -> tensor<7x2x1xf32>
    %cast = tensor.cast %8 : tensor<5x10x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<7x2x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<7x2x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}