module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<200> : tensor<5x4x8x8xi16>}> : () -> tensor<5x4x8x8xi16>
    %1 = "tosa.const"() <{values = dense<-93> : tensor<1x1x8x1xi16>}> : () -> tensor<1x1x8x1xi16>
    %2 = tosa.add %0, %1 : (tensor<5x4x8x8xi16>, tensor<1x1x8x1xi16>) -> tensor<5x4x8x8xi16>
    %cast = tensor.cast %2 : tensor<5x4x8x8xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

