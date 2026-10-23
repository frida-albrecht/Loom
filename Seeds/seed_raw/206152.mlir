module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.349000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<6> : tensor<8x8x8xi8>}> : () -> tensor<8x8x8xi8>
    %2 = tosa.floor %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_product %1 {axis = 0 : i32} : (tensor<8x8x8xi8>) -> tensor<1x8x8xi8>
    %4 = tosa.sub %3, %3 : (tensor<1x8x8xi8>, tensor<1x8x8xi8>) -> tensor<1x8x8xi8>
    %5 = tosa.reverse %4 {axis = 0 : i32} : (tensor<1x8x8xi8>) -> tensor<1x8x8xi8>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<1x8x8xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

