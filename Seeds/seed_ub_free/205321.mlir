module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<144> : tensor<8x5x4xi16>}> : () -> tensor<8x5x4xi16>
    %1 = tosa.reduce_product %0 {axis = 2 : i32} : (tensor<8x5x4xi16>) -> tensor<8x5x1xi16>
    %2 = tosa.add %1, %1 : (tensor<8x5x1xi16>, tensor<8x5x1xi16>) -> tensor<8x5x1xi16>
    %cast = tensor.cast %2 : tensor<8x5x1xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

