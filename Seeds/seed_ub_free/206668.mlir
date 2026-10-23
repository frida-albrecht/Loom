module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<26> : tensor<4x5x8x5xi32>}> : () -> tensor<4x5x8x5xi32>
    %1 = "tosa.const"() <{values = dense<-1.896200e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %2 = tosa.argmax %0 {axis = 3 : i32} : (tensor<4x5x8x5xi32>) -> tensor<4x5x8xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x5x8xi32>}> : () -> tensor<4x5x8xi32>
    %c1 = "tosa.const"() <{values = dense<31> : tensor<4x5x8xi32>}> : () -> tensor<4x5x8xi32>
    %cl2 = tosa.maximum %2, %c0 : (tensor<4x5x8xi32>, tensor<4x5x8xi32>) -> tensor<4x5x8xi32>
    %cl3 = tosa.minimum %cl2, %c1 : (tensor<4x5x8xi32>, tensor<4x5x8xi32>) -> tensor<4x5x8xi32>
    %3 = tosa.arithmetic_right_shift %2, %cl3 {round = true} : (tensor<4x5x8xi32>, tensor<4x5x8xi32>) -> tensor<4x5x8xi32>
    %4 = tosa.exp %1 : (tensor<4xf32>) -> tensor<4xf32>
    %5 = tosa.clz %3 : (tensor<4x5x8xi32>) -> tensor<4x5x8xi32>
    %6 = tosa.clz %5 : (tensor<4x5x8xi32>) -> tensor<4x5x8xi32>
    %7 = tosa.add %6, %5 : (tensor<4x5x8xi32>, tensor<4x5x8xi32>) -> tensor<4x5x8xi32>
    %cast = tensor.cast %4 : tensor<4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<4x5x8xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}