module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<20> : tensor<2x6x2x6xi8>}> : () -> tensor<2x6x2x6xi8>
    %1 = "tosa.const"() <{values = dense<12> : tensor<2x1x2x1xi8>}> : () -> tensor<2x1x2x1xi8>
    %2 = tosa.minimum %0, %1 : (tensor<2x6x2x6xi8>, tensor<2x1x2x1xi8>) -> tensor<2x6x2x6xi8>
    %3 = tosa.reduce_sum %2 {axis = 3 : i32} : (tensor<2x6x2x6xi8>) -> tensor<2x6x2x1xi8>
    %4 = tosa.reduce_sum %3 {axis = 2 : i32} : (tensor<2x6x2x1xi8>) -> tensor<2x6x1x1xi8>
    %5 = tosa.concat %4, %4 {axis = 3 : i32} : (tensor<2x6x1x1xi8>, tensor<2x6x1x1xi8>) -> tensor<2x6x1x2xi8>
    %6 = tosa.bitwise_or %5, %5 : (tensor<2x6x1x2xi8>, tensor<2x6x1x2xi8>) -> tensor<2x6x1x2xi8>
    %7 = tosa.reduce_product %6 {axis = 1 : i32} : (tensor<2x6x1x2xi8>) -> tensor<2x1x1x2xi8>
    %cast = tensor.cast %7 : tensor<2x1x1x2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

