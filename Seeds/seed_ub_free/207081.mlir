module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.063000e+01> : tensor<4x7x7x2xf32>}> : () -> tensor<4x7x7x2xf32>
    %1 = "tosa.const"() <{values = dense<16> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<-9> : tensor<i8>}> : () -> tensor<i8>
    %3 = tosa.reduce_product %0 {axis = 3 : i32} : (tensor<4x7x7x2xf32>) -> tensor<4x7x7x1xf32>
    %4 = tosa.bitwise_xor %1, %2 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %5 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<4x7x7x1xf32>) -> tensor<1x7x7x1xf32>
    %6 = tosa.reduce_product %5 {axis = 0 : i32} : (tensor<1x7x7x1xf32>) -> tensor<1x7x7x1xf32>
    %cast = tensor.cast %4 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<1x7x7x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

