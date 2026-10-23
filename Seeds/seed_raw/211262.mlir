module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4> : tensor<7x7xi8>}> : () -> tensor<7x7xi8>
    %1 = tosa.clamp %0 {max_val = -20 : i8, min_val = -27 : i8} : (tensor<7x7xi8>) -> tensor<7x7xi8>
    %2 = tosa.reverse %1 {axis = 0 : i32} : (tensor<7x7xi8>) -> tensor<7x7xi8>
    %3 = tosa.sub %2, %1 : (tensor<7x7xi8>, tensor<7x7xi8>) -> tensor<7x7xi8>
    %4 = tosa.logical_left_shift %3, %1 : (tensor<7x7xi8>, tensor<7x7xi8>) -> tensor<7x7xi8>
    %cast = tensor.cast %4 : tensor<7x7xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

