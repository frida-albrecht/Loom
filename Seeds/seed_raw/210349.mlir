module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8> : tensor<3xi8>}> : () -> tensor<3xi8>
    %1 = "tosa.const"() <{values = dense<1.812600e+02> : tensor<3x8x7xf32>}> : () -> tensor<3x8x7xf32>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<3xi8>) -> tensor<i32>
    %3 = tosa.log %1 : (tensor<3x8x7xf32>) -> tensor<3x8x7xf32>
    %4 = tosa.reduce_min %3 {axis = 1 : i32} : (tensor<3x8x7xf32>) -> tensor<3x1x7xf32>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<3x1x7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

