module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6> : tensor<6x4x8x5xi8>}> : () -> tensor<6x4x8x5xi8>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<6x4x8x5xi8>) -> tensor<1x4x8x5xi8>
    %2 = tosa.reduce_max %1 {axis = 3 : i32} : (tensor<1x4x8x5xi8>) -> tensor<1x4x8x1xi8>
    %3 = tosa.bitwise_or %2, %2 : (tensor<1x4x8x1xi8>, tensor<1x4x8x1xi8>) -> tensor<1x4x8x1xi8>
    %cast = tensor.cast %3 : tensor<1x4x8x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

