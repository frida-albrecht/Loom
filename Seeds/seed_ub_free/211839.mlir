module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<171> : tensor<8x5x4xi32>}> : () -> tensor<8x5x4xi32>
    %1 = "tosa.const"() <{values = dense<-176> : tensor<1x5x1xi32>}> : () -> tensor<1x5x1xi32>
    %2 = "tosa.const"() <{values = dense<-1.574400e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.add %0, %1 : (tensor<8x5x4xi32>, tensor<1x5x1xi32>) -> tensor<8x5x4xi32>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<8x5x4xi32>, tensor<8x5x4xi32>) -> tensor<8x5x4xi32>
    %5 = tosa.rsqrt %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<8x5x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

