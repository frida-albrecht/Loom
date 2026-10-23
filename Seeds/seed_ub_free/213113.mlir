module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<5x1x1xi8>}> : () -> tensor<5x1x1xi8>
    %1 = tosa.abs %0 : (tensor<5x1x1xi8>) -> tensor<5x1x1xi8>
    %2 = tosa.const_shape  {values = dense<[5, 1, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.reshape %1, %2 : (tensor<5x1x1xi8>, !tosa.shape<4>) -> tensor<5x1x1x1xi8>
    %4 = tosa.add %3, %3 : (tensor<5x1x1x1xi8>, tensor<5x1x1x1xi8>) -> tensor<5x1x1x1xi8>
    %5 = tosa.clamp %4 {max_val = 86 : i8, min_val = -15 : i8} : (tensor<5x1x1x1xi8>) -> tensor<5x1x1x1xi8>
    %6 = tosa.bitwise_or %5, %5 : (tensor<5x1x1x1xi8>, tensor<5x1x1x1xi8>) -> tensor<5x1x1x1xi8>
    %7 = tosa.reduce_sum %6 {axis = 3 : i32} : (tensor<5x1x1x1xi8>) -> tensor<5x1x1x1xi8>
    %cast = tensor.cast %7 : tensor<5x1x1x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

