module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-10> : tensor<3x2x5x8xi16>}> : () -> tensor<3x2x5x8xi16>
    %1 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 3, 1, 2>} : (tensor<3x2x5x8xi16>) -> tensor<3x8x2x5xi16>
    %3 = tosa.bitwise_or %2, %2 : (tensor<3x8x2x5xi16>, tensor<3x8x2x5xi16>) -> tensor<3x8x2x5xi16>
    %4 = tosa.sub %3, %3 : (tensor<3x8x2x5xi16>, tensor<3x8x2x5xi16>) -> tensor<3x8x2x5xi16>
    %5 = tosa.abs %4 : (tensor<3x8x2x5xi16>) -> tensor<3x8x2x5xi16>
    %6 = tosa.concat %5, %5 {axis = 3 : i32} : (tensor<3x8x2x5xi16>, tensor<3x8x2x5xi16>) -> tensor<3x8x2x10xi16>
    %cast = tensor.cast %6 : tensor<3x8x2x10xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

