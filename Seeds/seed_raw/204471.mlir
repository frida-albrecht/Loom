module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<8x7x8x1xi8>}> : () -> tensor<8x7x8x1xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<8x7x8x7xi8>}> : () -> tensor<8x7x8x7xi8>
    %2 = tosa.concat %0, %1 {axis = 3 : i32} : (tensor<8x7x8x1xi8>, tensor<8x7x8x7xi8>) -> tensor<8x7x8x8xi8>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = true} : (tensor<8x7x8x8xi8>, tensor<8x7x8x8xi8>) -> tensor<8x7x8x8xi8>
    %4 = tosa.minimum %3, %3 : (tensor<8x7x8x8xi8>, tensor<8x7x8x8xi8>) -> tensor<8x7x8x8xi8>
    %5 = tosa.reduce_max %4 {axis = 3 : i32} : (tensor<8x7x8x8xi8>) -> tensor<8x7x8x1xi8>
    %6 = tosa.reduce_sum %5 {axis = 2 : i32} : (tensor<8x7x8x1xi8>) -> tensor<8x7x1x1xi8>
    %cast = tensor.cast %6 : tensor<8x7x1x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

