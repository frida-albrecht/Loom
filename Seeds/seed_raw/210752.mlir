module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.878000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<20> : tensor<9xi8>}> : () -> tensor<9xi8>
    %2 = tosa.ceil %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_sum %1 {axis = 0 : i32} : (tensor<9xi8>) -> tensor<1xi8>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

