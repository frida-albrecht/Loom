module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<46> : tensor<5x4x2xi32>}> : () -> tensor<5x4x2xi32>
    %1 = "tosa.const"() <{values = dense<-6.037000e+01> : tensor<1x5xf32>}> : () -> tensor<1x5xf32>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<5x4x2xi32>) -> tensor<4x2xi32>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<4x2xi32>, tensor<4x2xi32>) -> tensor<4x2xi32>
    %4 = tosa.sigmoid %1 : (tensor<1x5xf32>) -> tensor<1x5xf32>
    %5 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<1x5xf32>) -> tensor<1x1xf32>
    %6 = tosa.logical_right_shift %3, %3 : (tensor<4x2xi32>, tensor<4x2xi32>) -> tensor<4x2xi32>
    %cast = tensor.cast %5 : tensor<1x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<4x2xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

