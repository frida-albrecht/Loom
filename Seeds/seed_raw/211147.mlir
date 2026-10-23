module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.363000e+01> : tensor<8x1x8x9xf32>}> : () -> tensor<8x1x8x9xf32>
    %1 = tosa.reduce_product %0 {axis = 3 : i32} : (tensor<8x1x8x9xf32>) -> tensor<8x1x8x1xf32>
    %2 = tosa.pow %1, %1 : (tensor<8x1x8x1xf32>, tensor<8x1x8x1xf32>) -> tensor<8x1x8x1xf32>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<8x1x8x1xf32>) -> tensor<1x8x1xi32>
    %4 = tosa.ceil %1 : (tensor<8x1x8x1xf32>) -> tensor<8x1x8x1xf32>
    %cast = tensor.cast %3 : tensor<1x8x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<8x1x8x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

