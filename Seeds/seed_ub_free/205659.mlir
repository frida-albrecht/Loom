module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5> : tensor<2x9x4xi8>}> : () -> tensor<2x9x4xi8>
    %1 = tosa.clz %0 : (tensor<2x9x4xi8>) -> tensor<2x9x4xi8>
    %2 = tosa.bitwise_and %1, %1 : (tensor<2x9x4xi8>, tensor<2x9x4xi8>) -> tensor<2x9x4xi8>
    %3 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<2x9x4xi8>) -> tensor<2x1x4xi8>
    %4 = tosa.concat %3, %3 {axis = 0 : i32} : (tensor<2x1x4xi8>, tensor<2x1x4xi8>) -> tensor<4x1x4xi8>
    %5 = tosa.bitwise_or %4, %4 : (tensor<4x1x4xi8>, tensor<4x1x4xi8>) -> tensor<4x1x4xi8>
    %6 = tosa.reverse %5 {axis = 2 : i32} : (tensor<4x1x4xi8>) -> tensor<4x1x4xi8>
    %7 = tosa.reduce_sum %6 {axis = 2 : i32} : (tensor<4x1x4xi8>) -> tensor<4x1x1xi8>
    %8 = tosa.bitwise_not %7 : (tensor<4x1x1xi8>) -> tensor<4x1x1xi8>
    %cast = tensor.cast %8 : tensor<4x1x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

