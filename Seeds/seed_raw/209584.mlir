module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.241600e+02> : tensor<1x5xf32>}> : () -> tensor<1x5xf32>
    %1 = "tosa.const"() <{values = dense<15> : tensor<4xi8>}> : () -> tensor<4xi8>
    %2 = tosa.reciprocal %0 : (tensor<1x5xf32>) -> tensor<1x5xf32>
    %3 = tosa.reduce_product %2 {axis = 1 : i32} : (tensor<1x5xf32>) -> tensor<1x1xf32>
    %4 = tosa.bitwise_not %1 : (tensor<4xi8>) -> tensor<4xi8>
    %5 = tosa.reverse %3 {axis = 0 : i32} : (tensor<1x1xf32>) -> tensor<1x1xf32>
    %6 = tosa.logical_right_shift %4, %4 : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %7 = tosa.concat %6, %4 {axis = 0 : i32} : (tensor<4xi8>, tensor<4xi8>) -> tensor<8xi8>
    %cast = tensor.cast %5 : tensor<1x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<8xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

